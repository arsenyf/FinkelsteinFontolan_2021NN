function get_ingestion_progress()

disp('--------------------- INGESTION PROGRESS --------------------------')

total_session_count = 98;

NWBtoDataJointIngestion = ingestion.getSchema().v.NWBtoDataJointIngestion;
IngestionStatus = ingestion.getSchema().v.IngestionStatus;

ingested_session_count = length(fetch(IngestionStatus & 'status = "complete"'));
error_session_count = length(fetch(IngestionStatus & 'status = "error"'));

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

