public with sharing class LeadController {
    @AuraEnabled(cacheable=true)
    public static List<Lead> getLatestLeads() {
        return[SELECT  FirstName, LastName, Title, Company
                FROM Lead
                WITH SECURITY_ENFORCED
                ORDER BY CreatedDate DESC 
                LIMIT 5];
    }
}
