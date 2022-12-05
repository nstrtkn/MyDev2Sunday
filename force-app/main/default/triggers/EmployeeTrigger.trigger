trigger EmployeeTrigger on Employee__c (after insert) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            EmployeeHandler.afterInsert(Trigger.new);
        }
    }
}