public class StatisticsService {

    public static void updatePlacementStatistics(
        List<Application__c> applications
    ) {

        Integer selectedCount = [
            SELECT COUNT()
            FROM Application__c
            WHERE Status__c = 'Selected'
        ];

        System.debug(
            'Total selected applications: ' + selectedCount
        );
    }
}
