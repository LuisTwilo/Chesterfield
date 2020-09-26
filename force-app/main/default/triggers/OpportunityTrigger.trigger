trigger OpportunityTrigger on Opportunity (after insert, after update) {
    
    OpportunityTriggerHandler.insertHandler(Trigger.newMap);
    // if(Trigger.isUpdate)OpportunityTriggerHandler.updateHandler(Trigger.newMap, Trigger.oldMap);
      
}