public with sharing class OpportunityController {
    @AuraEnabled(cacheable=true)
    public static decimal displayOppAmounts(String stage) {

        decimal sum = 0;

        for (Opportunity opp : [SELECT StageName, Amount
               FROM Opportunity
               WHERE Amount != NULL
               AND StageName =:stage
               WITH SECURITY_ENFORCED]) {
            
            sum = sum + opp.Amount;
        }

        return sum;
    }
    
}
