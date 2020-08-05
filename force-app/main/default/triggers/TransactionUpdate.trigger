trigger TransactionUpdate on Transaction__c (after insert, after update, after delete) {

    List<Transaction__c> trans = Trigger.isDelete? Trigger.Old: Trigger.New;
    List<Id> userIds = getUsersIdList(trans);
    
    Map<Id, User> users = new Map<Id, User>([SELECT Id, Balance__c FROM User WHERE Id IN: userIds]);
    
        Decimal difference;
       
        for(Transaction__c t: trans) {
            difference = t.Amount__c;
            
            if(Trigger.isUpdate) {
                difference -= Trigger.oldMap.get(t.Id).Amount__c; // new amount - old amount
            } else if(Trigger.isDelete) {
                difference = -difference;
            }
            
            User u = users.get(t.AccOwnerId__c);
            u.Balance__c += difference;
        }

        update users.values();


    private static List<Id> getUsersIdList(List<Transaction__c> transactions) {
        Set<Id> userIds = new Set<Id>();

        for(Transaction__c t: transactions) {
            userIds.add(t.AccOwnerId__c);
        }

        return new List<Id>(userIds);
    }

}