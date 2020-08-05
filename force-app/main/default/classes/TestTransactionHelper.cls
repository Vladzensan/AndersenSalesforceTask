@isTest
private class TestTransactionHelper {
    @isTest
    static void testHelper() {
        User usr = TestDataProvider.getUser();
        
        Test.startTest();
        insert usr;
        
        Transaction__c t1 = new Transaction__c(Amount__c=100, Purpose__c='Test', AccOwnerId__c=usr.Id);
        Transaction__c t2 = new Transaction__c(Amount__c=100, Purpose__c='Test', AccOwnerId__c=usr.Id);
        insert new List<Transaction__c>{t1,t2};
            
        List<Transaction__c> trans = TransactionHelper.getUserTransactions(usr.Id);
        Test.stopTest();
        
        System.assertEquals(2, trans.size());
    }
}
