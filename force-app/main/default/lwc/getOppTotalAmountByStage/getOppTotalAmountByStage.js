import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import { LightningElement, wire } from 'lwc';

import STAGE_FIELD from '@salesforce/schema/Opportunity.StageName';
import OPP_OBJECT from '@salesforce/schema/Opportunity';
import displayOppAmount from '@salesforce/apex/OpportunityController.displayOppAmounts';


export default class GetOppTotalAmountByStage extends LightningElement {

    stageOptions =[];
    opps;
    error;
    sum;

    @wire(getObjectInfo,{objectApiName:OPP_OBJECT})
    oppInfo;

    @wire(getPicklistValues,{fieldApiName :STAGE_FIELD , recordTypeId :'$oppInfo.data.defaultRecordTypeId'})

    picklistHandler({data,error}){
        if (data) {
            this.stageOptions = data.values; 
    }
    if (error) {
        console.error(error);
    }
    }

    changeHandler(event){
        const selectedStage = event.target.value;
        displayOppAmount({stage: selectedStage})
        .then(result => {
            if (result > 0) {
                this.sum = result;
                this.error= undefined;
            }
            else {
                this.sum = undefined;
                this.error = " There are no matching opportunities for the selected stage.Please select another";
            }
            })
            .catch(error => {
                this.sum = undefined;
                this.error = error.body.message;
            })
        
    }
}