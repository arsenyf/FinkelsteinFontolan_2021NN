function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    cfg = dj.config; 
    schemaObject = dj.Schema(dj.conn, 'ingestion', [cfg.custom.databasePrefix, 'ingestion']);
end
obj = schemaObject;
end
