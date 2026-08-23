/**
 * ContactActivityController
 * Supplies open/closed activities and related opportunities for a Contact,
 * used by the contactActivityPanel LWC on the Contact record page.
 */
public with sharing class ContactActivityController {

    public class ActivityWrapper {
        @AuraEnabled public Id taskId;
        @AuraEnabled public String subject;
        @AuraEnabled public String status;
        @AuraEnabled public Date activityDate;
        @AuraEnabled public Boolean isOverdue;
    }

    @AuraEnabled(cacheable=true)
    public static List<ActivityWrapper> getActivitiesForContact(Id contactId) {
        List<ActivityWrapper> wrapped = new List<ActivityWrapper>();

        List<Task> tasks = [
            SELECT Id, Subject, Status, ActivityDate
            FROM Task
            WHERE WhoId = :contactId
            WITH SECURITY_ENFORCED
            ORDER BY ActivityDate DESC NULLS LAST
            LIMIT 50
        ];

        for (Task t : tasks) {
            ActivityWrapper w = new ActivityWrapper();
            w.taskId = t.Id;
            w.subject = t.Subject;
            w.status = t.Status;
            w.activityDate = t.ActivityDate;
            w.isOverdue = (t.ActivityDate != null
                            && t.ActivityDate < Date.today()
                            && t.Status != 'Completed');
            wrapped.add(w);
        }
        return wrapped;
    }

    @AuraEnabled
    public static Id logActivity(Id contactId, String subject, String activityType, Date dueDate) {
        if (!Schema.sObjectType.Task.isCreateable()) {
            throw new AuraHandledException('You do not have permission to create Tasks.');
        }
        Task t = new Task(
            WhoId = contactId,
            Subject = subject,
            Type = activityType,
            ActivityDate = dueDate,
            Status = 'Not Started'
        );
        try {
            insert t;
            return t.Id;
        } catch (DmlException e) {
            throw new AuraHandledException('Could not log activity: ' + e.getDmlMessage(0));
        }
    }
}