import { LightningElement, track } from 'lwc';
import LEAD_OBJECT from '@salesforce/schema/Lead';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class CreateLeadRecord extends LightningElement {
    @track formdataLead = {};

    changeHandler(event){
        const{name, value} = event.target;
        this.formdataLead[name] = value;
    }
    cancelLead(){
        this.template.querySelector('form.leadform').reset();
        this.fields = {};
    }
    saveLead(){
        const recordInput = {
            apiName: LEAD_OBJECT.objectApiName, 
            fields: this.formdataLead
        };
        createRecord(recordInput)
        .then(result => {
            console.log(result);
            this.displayToast("Success", "Lead Record has been created successfully!", "success");

            this.template.querySelector('form.leadform').reset();
            this.fields = {};
            
        
        })
        .catch(error => {
            console.error(error);
            this.displayToast("Error", error.body.message, "error");

            
        })
    }
    displayToast(title, message, variant){
        const toast = new ShowToastEvent ({title, message, variant});
        this.dispatchEvent(toast);
    }
}