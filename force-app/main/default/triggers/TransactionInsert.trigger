trigger TransactionInsert on Transaction__c (before insert) {
    for(Transaction__c t: Trigger.New) {
        t.Creation_Time__c = Datetime.now();
    }
}