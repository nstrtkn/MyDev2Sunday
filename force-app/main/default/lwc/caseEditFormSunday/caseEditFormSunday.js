import { LightningElement } from 'lwc';
import OBJ_NAME from '@salesforce/schema/Case';
import ACC_NAME from '@salesforce/schema/Case.AccountId';
import CONT_NAME from '@salesforce/schema/Case.ContactId';
import SUBJECT from '@salesforce/schema/Case.Subject';
import PRIORITY from '@salesforce/schema/Case.Priority';
import STATUS from '@salesforce/schema/Case.Status';
import DESC from '@salesforce/schema/Case.Description';
import ORIGIN from '@salesforce/schema/Case.Origin';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CaseEditFormSunday extends LightningElement {

    recordId = "500Do000001mSMsIAM";
    objectName = OBJ_NAME;

    fields = {
        accName : ACC_NAME,
        contName : CONT_NAME,
        subject : SUBJECT,
        priority : PRIORITY,
        status : STATUS,
        desc : DESC,
        origin : ORIGIN
    };

    successHandler(event) {
        const successEvent = new ShowToastEvent({
            title : "Success",
            message : "Case record has been created successfully.",
            variant : "success",
        });
        this.dispatchEvent(successEvent);
    }
}