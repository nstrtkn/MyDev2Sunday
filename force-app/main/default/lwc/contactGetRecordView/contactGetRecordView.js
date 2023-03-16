import { getFieldValue, getRecord } from 'lightning/uiRecordApi';
import { LightningElement, wire } from 'lwc';

import CON_NAME from '@salesforce/schema/Contact.Name';
import CON_TITLE from '@salesforce/schema/Contact.Title';
import CON_EMAIL from '@salesforce/schema/Contact.Email';
import MOBILE from '@salesforce/schema/Contact.MobilePhone';
import CON_DEPARTMENT from '@salesforce/schema/Contact.Department';

const FIELDS = [CON_NAME, CON_TITLE, CON_EMAIL, MOBILE, CON_DEPARTMENT];

export default class ContactGetRecordView extends LightningElement {
    
    recordId = "003Do000002Nj7aIAC";
    name;
    title;
    email;
    mobile;
    department; 

    @wire(getRecord, {recordId: '$recordId', fields: FIELDS})
    recordHandler({data, error}) {
        if(data) {
            console.log(data);
            this.name = getFieldValue(data, CON_NAME);
            this.title = getFieldValue(data, CON_TITLE);
            this.email = getFieldValue(data, CON_EMAIL);
            this.mobile = getFieldValue(data, MOBILE);
            this.department = getFieldValue(data, CON_DEPARTMENT);
        }
        if(error) {
            console.error(error);
        }
    }
}