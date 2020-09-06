public with sharing class TransactionHelper {

    @AuraEnabled(cacheable=true)
    public static List<Transaction__c> getUserTransactions(Id userId) {
        List<Transaction__c> transactions = [SELECT AccOwnerId__c, Amount__c, Purpose__c FROM Transaction__c WHERE AccOwnerId__c=:userId ORDER BY Creation_Time__c DESC];
        
        SObjectAccessDecision decision;
        try {
            decision = Security.stripInaccessible( // also checks object-level access, if fails -> NoAccessException
            AccessType.UPDATABLE,
            transactions);
        } catch(NoAccessException e) {
            throw new AuraHandledException('You have no access to Transaction object (' + e.getMessage() + ')');  
        }

        return (List<Transaction__c>) decision.getRecords();
    }
}