import { LightningElement } from 'lwc';
import getLatestLeads from '@salesforce/apex/LeadController.getLatestLeads';

const COLUMNS= [
    {label:"FName" , fieldName:"FirstName" , type: "text"},
    {label:"LName" , fieldName:"LastName" , type: "text"},
    {label:"Title" , fieldName:"Title" , type: "text"},
    {label:"Company" , fieldName:"Company" , type: "text"}
];

export default class GetLast5Leads extends LightningElement {

    columns= COLUMNS;
    leads;
    error;
    ApexMethod(){
        if(this.leads || this.error){
            this.leads = undefined;
            this.error = undefined;

        }else{
        getLatestLeads()
        .then(result =>{
        this.leads = result;

        })
        .catch(error=>{
        this.error = error;
        })
    }

    }
}