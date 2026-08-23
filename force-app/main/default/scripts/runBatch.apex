Id jobId = Database.executeBatch(
    new ExpiredJobBatch(),
    50
);

System.debug('Batch Job Id: ' + jobId);
