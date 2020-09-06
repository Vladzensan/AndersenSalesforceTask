public with sharing class TestDataProvider {
    public static final Integer DEFAULT_AMOUNT = 100;
    public static User generateUser(String profileName) {
         Profile profileId = [SELECT Id FROM Profile WHERE Name =: profileName LIMIT 1];

		 User usr = new User(LastName = 'LIVESTON',
                   FirstName='JASON',
                   Alias = 'jliv',
                   Email = 'jason.liveston@asdf.com',
                   Username = 'testuser1984@test.com',
                   ProfileId = profileId.id,
                   TimeZoneSidKey = 'GMT',
                   LanguageLocaleKey = 'en_US',
                   CommunityNickname = 'wlef,lwfe,lw',
                   EmailEncodingKey = 'UTF-8',
                   LocaleSidKey = 'en_US',
                   Balance__c = 0
                   );
        
        insert usr;

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

    public static void assignPermissionSet(Id userId, String permSetLabel) {
        PermissionSet permSet = [SELECT Id FROM PermissionSet WHERE Label=:permSetLabel][0];

        PermissionSetAssignment psa = new PermissionSetAssignment(PermissionSetId = permSet.Id, AssigneeId = userId);
        insert psa;  
    }
}
