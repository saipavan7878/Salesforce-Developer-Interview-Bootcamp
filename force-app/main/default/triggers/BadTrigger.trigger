trigger BadTrigger on Account (after insert) {

    Set<Id> accountIds = new Set<Id>();

    for (Account acc : Trigger.new) {
        accountIds.add(acc.Id);
    }

    List<Account> accounts = [
        SELECT Id, Name
        FROM Account
        WHERE Id IN :accountIds
    ];

    for (Account acc : accounts) {
        System.debug(acc.Name);
    }
}