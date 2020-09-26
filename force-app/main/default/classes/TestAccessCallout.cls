@isTest
public with sharing class TestAccessCallout {
    @TestSetup
    static void makeData(){
        List<Opportunity> opps = new List<Opportunity>();
        Map<Id,Opportunity> oppmap = new  Map<Id,Opportunity>();
        for(Integer i = 0; i<100; i++){
            Opportunity o = new Opportunity();
            o.Name = 'Test'+i;
            o.AccountId='00101000002gzv4AAA';
            o.StageName = 'Initial Contact';
            o.CloseDate = System.today();
            o.StageName = 'Closed Won';

            opps.add(o);
        }
        insert opps;
    }
    
    
    @isTest
    private static void postCalloutTest(){
        
        System.Test.setMock(HttpCalloutMock.class, new MockCalloutResponse());
        System.Test.startTest();
        Map<Id,Opportunity> oppMap = new Map<Id,Opportunity>([SELECT Id, Name FROM Opportunity WHERE Name = 'Test1' AND Name = 'Test2' ]);
        OpportunityTriggerHandler.insertHandler(oppMap);
        System.Test.stopTest();
    }
}
