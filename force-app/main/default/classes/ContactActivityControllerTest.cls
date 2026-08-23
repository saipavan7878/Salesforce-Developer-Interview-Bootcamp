@isTest
private class ContactActivityControllerTest {

    @TestSetup
    static void setup() {
        Contact c = new Contact(LastName = 'Doe', FirstName = 'John');
        insert c;

        insert new Task(
            WhoId = c.Id,
            Subject = 'Follow-up call',
            ActivityDate = Date.today().addDays(-2),
            Status = 'Not Started'
        );
    }

    @isTest
    static void testGetActivitiesForContactFlagsOverdue() {
        Contact c = [SELECT Id FROM Contact LIMIT 1];

        Test.startTest();
        List<ContactActivityController.ActivityWrapper> activities =
            ContactActivityController.getActivitiesForContact(c.Id);
        Test.stopTest();

        System.assertEquals(1, activities.size());
        System.assertEquals(true, activities[0].isOverdue);
    }

    @isTest
    static void testLogActivityCreatesTask() {
        Contact c = [SELECT Id FROM Contact LIMIT 1];

        Test.startTest();
        Id newTaskId = ContactActivityController.logActivity(
            c.Id, 'Send proposal', 'Email', Date.today().addDays(3)
        );
        Test.stopTest();

        System.assertNotEquals(null, newTaskId);
        Task t = [SELECT Subject, Status FROM Task WHERE Id = :newTaskId];
        System.assertEquals('Send proposal', t.Subject);
        System.assertEquals('Not Started', t.Status);
    }
}