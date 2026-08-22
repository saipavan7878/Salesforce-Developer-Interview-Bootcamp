trigger ApplicationTrigger on Application__c (
    before insert,
    after update
) {

    // Before Insert
    if (Trigger.isBefore && Trigger.isInsert) {
        ApplicationTriggerHandler.beforeInsert(Trigger.new);
    }

    // After Update
    if (Trigger.isAfter && Trigger.isUpdate) {
        ApplicationTriggerHandler.afterUpdate(
            Trigger.new,
            Trigger.oldMap
        );
    }
}
