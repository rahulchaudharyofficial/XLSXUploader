import { LightningElement, track, wire } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import getAccessibleMetadata from "@salesforce/apex/MetadataManagerController.getAccessibleMetadata";
import getCSVHeaders from "@salesforce/apex/MetadataManagerController.getCSVHeaders";
import submitDataUpload from "@salesforce/apex/MetadataManagerController.submitDataUpload";

export default class MetadataManager extends LightningElement {
  overallProgress = {};

  progressSteps = [
    {
      label: "Metadata",
      value: "1"
    },
    {
      label: "File",
      value: "2"
    },
    {
      label: "Confirmation",
      value: "3"
    },
    {
      label: "Complete",
      value: "4"
    }
  ];

  mappingMessage = '';

  showDataLoad = false;
  dataCols = [];
  dataVals=[];
  finalPayload = null;

  isDataAccepted = false;

  metadataWithFieldsDetails;

  @track loaded = true;

  metadataDetails = [];

  hasSteps = this.progressSteps ? true : false;
  currentStep = "1";
  fileUploader = false;
  @track selectedMetadata = "";
  fileNextDisabled = true;
  metadataNextDisabled = true;

  @wire(getAccessibleMetadata)
  async metadataAndFields({ error, data }) {
    let metadata = [];
    if (data) {
      this.metadataWithFieldsDetails = data;
      //console.log(JSON.stringify(data));
      this.metadataWithFieldsDetails.forEach((mdt) => {
        metadata.push({
          label: mdt.label,
          value: mdt.name
        });
      });
      this.metadataDetails = await metadata;
      this.loaded = false;
    } else if (error) {
      this.showNotification(
        "Error Occured",
        "Failed to fetch metadata details",
        "error"
      );
    }
  }

  showNotification(tit, msg, typ) {
    const evt = new ShowToastEvent({
      title: tit,
      message: msg,
      variant: typ
    });

    this.dispatchEvent(evt);
  }

  get acceptedFormats() {
    return [".csv"];
  }

  selectMetadata() {
    this.currentStep = "1";
    this.template.querySelector("div.fileSelector").classList.add("slds-hide");
    this.template
      .querySelector("div.metadataSelector")
      .classList.remove("slds-hide");
  }

  gotoFileSelector() {
    this.currentStep = "2";
    this.template
      .querySelector("div.metadataSelector")
      .classList.add("slds-hide");
    this.template
      .querySelector("div.fileSelector")
      .classList.remove("slds-hide");
      
      this.template.querySelector("div.mappingSelector")
      .classList.add("slds-hide");
  }

  handleUploadFinished(event) {
    this.overallProgress.fileUploader = event.detail.files[0];
    this.fileNextDisabled = false;
  }

  handleMetadataSelection(event) {
    let selectedVal = event.target.value;

    if (selectedVal) {
      this.overallProgress.metadata = event.target.value;
      this.metadataNextDisabled = false;
      this.fileNextDisabled = true;
    }

    console.log("Overall Progress : "+ JSON.stringify(this.overallProgress));
  }

  gotoMetadataSelector() {
    this.currentStep = "1";
    this.template
      .querySelector("div.fileSelector")
      .classList.add("slds-hide");
    this.template
      .querySelector("div.metadataSelector")
      .classList.remove("slds-hide");
  }

  selectMapping() {
    this.currentStep = "3";
    this.template
      .querySelector("div.mappingSelector")
      .classList.remove("slds-hide");
    this.template
      .querySelector("div.metadataSelector")
      .classList.add("slds-hide");
    this.template.querySelector("div.fileSelector").classList.add("slds-hide");
    this.loaded = true; 
    const documentId = this.overallProgress.fileUploader.documentId;
    const metadata = this.overallProgress.metadata;

    getCSVHeaders({metadata,documentId})
      .then(result => {
        if(!this.isDataAccepted) {
          this.showDataLoad = true;
        }
        this.finalPayload = result;
        this.loaded=false;
        this.dataCols = result.columns;
        this.dataVals = result.values;
      })
      .catch(error => {
        this.loaded=false;
        this.showNotification(
          "Error Occured",
          error,
          "error"
        );
      });
      this.loaded=false;
  }

  toggleDataModal() {
    if(this.showDataLoad) {
      this.mappingMessage = 'Oops, Is there a issue in the data. Please contact System admin for help';
    }
    else {
      this.mappingMessage='';
    }
    this.showDataLoad = !this.showDataLoad;

  }

  submitConfirmation() {
    this.mappingMessage = 'Thank you for confirmation, Please click on Finish button to begin data load. You will receive confirmation once completed';
    this.showDataLoad = false;
    this.isDataAccepted = true;
  }

  initiateDataLoad() {
      this.loaded = true;
      const inputDTO = this.finalPayload;
      submitDataUpload({inputDTO})
        .then(result => {
          console.log('Inside success block '+ JSON.stringify(result));
          this.loaded = false;
          this.currentStep = '4';
        })
        .catch(error => {
          console.log("Inside error block" + error);
          this.loaded = false;
          //TODO Handle ERROR
        });
  }
}