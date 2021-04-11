import { LightningElement, api, wire } from 'lwc';
import GET_ACTIVITY from '@salesforce/apex/ActivityTimelineController.getTaskByWhatId';

export default class ActivityItem extends LightningElement {
    @api recordId;
    @wire(GET_ACTIVITY, {recordId: '$recordId'})
    taskRecords;
}