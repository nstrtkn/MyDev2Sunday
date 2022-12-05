public with sharing class EmployeeHandler {
    
    public static void afterInsert(List<Employee__c> newEmployess) {
        for (Employee__c emp : newEmployess) {
            //Call future method by passing airline id
            EmployeeCallouts.postEmployeeDetails(emp.Id);
        }
    }
}
