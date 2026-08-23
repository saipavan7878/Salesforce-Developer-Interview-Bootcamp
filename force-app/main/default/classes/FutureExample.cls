public class FutureExample {

    @future
    public static void updateAccountName(Id accountId) {

        Account acc = [
            SELECT Id, Name
            FROM Account
            WHERE Id = :accountId
            LIMIT 1
        ];

        acc.Name = acc.Name + ' Updated';

        update acc;
    }
}