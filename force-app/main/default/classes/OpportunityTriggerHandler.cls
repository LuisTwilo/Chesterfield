public with sharing class OpportunityTriggerHandler{

    // https://ee2d443aa50a40ebb8ea2f4ea9509ca9.m.pipedream.net
    private static String endpoint = 'http://chesterfieldfence.org/zeus/infobase/infobase.mdb';
    private static Set<Id> opportunityIds = new Set<Id>(); 
    private static String query='SELECT Id, Name, OwnerName__c,Date_Sold__c, Project_Type__c,'+
            'Material_Type__c, Amount,  Account.FirstName, Account.LastName, Account.PersonContact.Email,'+
            ' Account.PersonContact.MobilePhone, Account.ShippingCity, Account.ShippingState,Account.ShippingStreet,'+
            'Account.ShippingPostalCode,Account.ShippingCountry,Account.BillingCity,'+              
            'Account.BillingCountry, Account.BillingState, Account.BillingStreet, Account.BillingPostalCode, '+
            'Account.Phone, Account.How_did_you_hear_about_us__c, Account.Referred_by__c '+
            'FROM Opportunity Where Id IN : idsToQuery';

    
    public static void insertHandler(Map<Id,Opportunity> newOpportunities){
        Set<Id> idsToQuery= new Set<Id>();
        opportunityIds = newOpportunities.keySet();
        for(Id oppId: opportunityIds){
            Opportunity opp = newOpportunities.get(oppId);
            if(opp.StageName == 'Closed Won' && opp.Date_Sold__c != null)idsToQuery.add(Opp.Id); 
        }
        if(idsToQuery.size() > 0){
            String dataToSend = JSON.serialize(database.query(query));
            Id jobId = System.enqueueJob(new AccessCalloutQueueable(dataToSend, endpoint));
        }  
    }
}

        