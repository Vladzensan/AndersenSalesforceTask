public with sharing class TestDataProvider {
    public static final Integer DEFAULT_AMOUNT = 100;
    public static User getUser() {
         Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];

		 User usr = new User(LastName = 'LIVESTON',
                   FirstName='JASON',
                   Alias = 'jliv',
                   Email = 'jason.liveston@asdf.com',
                   Username = 'vladzensan@asdf.com',
                   ProfileId = profileId.id,
                   TimeZoneSidKey = 'GMT',
                   LanguageLocaleKey = 'en_US',
                   EmailEncodingKey = 'UTF-8',
                   LocaleSidKey = 'en_US',
                   Balance__c = 0
                   );
        
        return usr;
        
    }
    
    public static List<Transaction__c> getUserTransactions(Id userId, Integer count) {
        List<Transaction__c> transactions = new List<Transaction__c>();
        
        for(Integer i = 0; i < count; i++) {
            Transaction__c t = new Transaction__c(Amount__c = DEFAULT_AMOUNT, AccOwnerId__c = userId, Purpose__c='Test purpose');
            transactions.add(t);
        }
        
        return transactions;
    }
}
