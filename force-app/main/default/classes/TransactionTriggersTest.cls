@isTest
private class TransactionTriggersTest {
    
    @isTest
    static void testInsertTime() {
        Id userId = UserInfo.getUserId();
        Transaction__c t = new Transaction__c(Amount__c=120,Purpose__c='test', AccOwnerId__c = userId);
        
        Test.startTest();
        insert t;
        t = [SELECT Creation_Time__c FROM Transaction__c WHERE Id=:t.Id][0];
        Test.stopTest();
        
        System.assert(t.Creation_Time__c != null);
    }
    
    @isTest
    static void testTransactionInsert() {
        Test.startTest();
        User usr = TestDataProvider.generateUser('Standard User');

        List<Transaction__c> trans = TestDataProvider.getUserTransactions(usr.Id, 10);
        insert trans;
        
        usr = [SELECT Balance__c FROM User WHERE Id=:usr.Id LIMIT 1];
        
        Test.stopTest();
        
        System.assertEquals(usr.Balance__c, 10 * TestDataProvider.DEFAULT_AMOUNT);

    }
    
    
    @isTest
    static void testTransactionUpdate() {
        Test.startTest();
        User usr = TestDataProvider.generateUser('Standard User');

        List<Transaction__c> trans = TestDataProvider.getUserTransactions(usr.Id, 10);
        insert trans;
        
        Transaction__c t = trans[0];
        t.Amount__c = TestDataProvider.DEFAULT_AMOUNT + 20;
        update t;
        
        usr = [SELECT Balance__c FROM User WHERE Id=:usr.Id LIMIT 1];
        
        Test.stopTest();
        
        System.assertEquals(usr.Balance__c, 10 * TestDataProvider.DEFAULT_AMOUNT + 20);

    }
    
    @isTest
    static void testTransactionDelete() {
        User usr = TestDataProvider.generateUser('Standard User');
        
        Test.startTest();
        
        List<Transaction__c> trans = TestDataProvider.getUserTransactions(usr.Id, 10);
        insert trans;
        
        Transaction__c t = trans[0];
        delete t;
        
        usr = [SELECT Balance__c FROM User WHERE Id=:usr.Id LIMIT 1];
        
        Test.stopTest();
        
        System.assertEquals(usr.Balance__c, 9 * TestDataProvider.DEFAULT_AMOUNT);

    }
}
