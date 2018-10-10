use admin;
config = {
   _id : "{ID}",
    members : [
        {_id : 0, host : "{SERVER_HOST}:{PORT0}" },
        {_id : 1, host : "{SERVER_HOST}:{PORT1}" },
        {_id : 2, host : "{SERVER_HOST}:{PORT2}", arbiterOnly: true }
    ]
};
rs.initiate(config);
