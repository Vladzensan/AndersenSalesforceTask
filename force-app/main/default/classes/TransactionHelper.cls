public with sharing class TransactionHelper {

    @AuraEnabled(cacheable=true)
    public static List<Transaction__c> getUserTransactions(Id userId) {
        return new List<Transaction__c>([SELECT AccOwnerId__c, Amount__c, Purpose__c FROM Transaction__c WHERE AccOwnerId__c=:userId ORDER BY Creation_Time__c DESC]);
    }
}