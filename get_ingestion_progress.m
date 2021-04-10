function get_ingestion_progress()

fprintf('--------------------- INGESTION PROGRESS --------------------------\n\n')

try
    d = dj.conn();
catch ME
    if strcmp(ME.identifier,'MySQL:Error')
        disp('Unable to connect to MySQL database server. Plese check the following:')
        disp('  1. Check if the Docker containers are running (Did you run "docker-compose up -d"?)')
        disp('  2. To restart MySQL server, do "docker-compose down" followed by "docker-compose up -d"')
        fprintf('\nTo get the latest ingestion status, run: get_ingestion_progress()\n\n')
        return
    end
end

total_session_count = 98;

NWBtoDataJointIngestion = ingestion.getSchema().v.NWBtoDataJointIngestion;
IngestionStatus = ingestion.getSchema().v.IngestionStatus;

try
    ingested_session_count = length(fetch(IngestionStatus & 'status = "complete"'));
    error_session_count = length(fetch(IngestionStatus & 'status = "error"'));
catch
    disp('Ingestion initializing. Please check back in a few minutes...')
    fprintf('\nTo get the latest ingestion status, run: get_ingestion_progress()\n\n')
    return
end
    
fprintf('%d/%d sessions ingested\n', ingested_session_count, total_session_count)
fprintf('%d session-ingestion errors\n', error_session_count)
fprintf('%d session in progress\n', total_session_count - (ingested_session_count + error_session_count))

if error_session_count ~= 0
    fprintf('\n\n\t----------------- Errors ----------------------\n')
    error_ingestions = (IngestionStatus & 'status = "error"');
    disp(error_ingestions)
end

fprintf('\nTo get the latest ingestion status, run: get_ingestion_progress()\n\n')

end

