public with sharing class EmployeeCallouts {
 
    @future(callout=true) 
    public static void postEmployeeDetails(Id employeeId) {
        
        //prepare data
        Employee__c emp = [SELECT Id, Name, Gender__c, Designation__c, Complete_Address__c, Email__c, Phone_Number__c, Username__c  FROM Employee__c WHERE Id =: employeeId];

        EmployeeWrapper wrap = new EmployeeWrapper();
        wrap.name = emp.Name;
        wrap.username = emp.Username__c;
        wrap.email = emp.Email__c;
        wrap.gender = emp.Gender__c;
        wrap.designation = emp.Designation__c;
        wrap.phone_number = emp.Phone_Number__c;
        wrap.complete_adress = emp.Complete_Address__c;
        String body = JSON.serialize(wrap);

        //1. Prepare HttpRequest and wrap all the necessary in it
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('https://api.onlinewebtutorblog.com/employees');
        request.setBody(body);
        request.setHeader('Content-Type', 'application/json');

        //2. Prepare Internet
        Http http = new Http();

        //3. Send the request over the internet to receive response back
        HttpResponse response = http.send(request);

        //4. Process the response
        emp.Integration_Status__c = Datetime.now()
        + ' ' + response.getStatusCode()
        + ' ' + response.getStatus()
        + ' ' + response.getBody();
    try {
        update emp;
    } catch(Exception ex) {
        //create a log
    }

    }
}
