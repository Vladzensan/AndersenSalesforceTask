@isTest
private class TestTransactionHelper {

    @TestSetup
    static void testSetup(){
        User usr = TestDataProvider.generateUser('Standard User');
        Transaction__c t1 = new Transaction__c(Amount__c=100, Purpose__c='Test', AccOwnerId__c=usr.Id);
        Transaction__c t2 = new Transaction__c(Amount__c=100, Purpose__c='Test', AccOwnerId__c=usr.Id);
        insert new List<Transaction__c>{t1,t2};
        
    }

    @isTest
    static void testHasAccess() {
        
        User usr = [SELECT Id FROM User WHERE Username = 'testuser1984@test.com'];
      
        TestDataProvider.assignPermissionSet(usr.Id, 'Transactions');

        System.runAs(usr) {
            Test.startTest();
            List<Transaction__c> trans = TransactionHelper.getUserTransactions(usr.Id);
            Test.stopTest();
            System.assertEquals(2, trans.size());
        }

    }

    @isTest
    static void testNoAccess() {
            User usr = [SELECT Id FROM User WHERE Username = 'testuser1984@test.com'];
            System.runAs(usr) {
                boolean isException = false;
                try {
                    Test.startTest();
                    List<Transaction__c> trans = TransactionHelper.getUserTransactions(usr.Id);
                    Test.stopTest();
                } catch (AuraHandledException e) {
                    isException = true;
                }
        
        
                System.assert(isException);
            }

      

    }
}
