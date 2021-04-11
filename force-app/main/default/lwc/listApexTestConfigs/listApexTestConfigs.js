import { LightningElement, track, wire } from 'lwc';
import GETAPEXTEST from '@salesforce/apex/ApexClassManager.getApexTestConfiguration';

export default class ListApexTestConfigs extends LightningElement {
    @track apxRecs = {};

   // @track columns = JSON.parse('[{"fieldName":"Id","label":"Id","type":"text"},{"fieldName":"Name","label":"Name","type":"text"}]');

    @track values = [];

    isError = false;
    error = null;

    @wire(GETAPEXTEST)
    async init({error, data}) {
        if(data) {
            this.apxRecs = await data;
            data.values.forEach(item => {
                this.values.push({
                    "Id" : item.apexTestSuiteId,
                    "Name" : item.apexTestSuiteName
                });
            });
        }
        if(error) {
            this.isError = true;
            this.error = error;
        }
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        console.log('actionname ' + actionName);
        console.log('row '+ JSON.stringify(row));
    }
}