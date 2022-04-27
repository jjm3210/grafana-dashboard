local function init(opts)
    if opts.is_master then
        local customers_space = box.schema.space.create('customers', {
            format = {
                {name = 'id', type = 'unsigned'},
                {name = 'bucket_id', type = 'unsigned'},
                {name = 'name', type = 'string'},
                {name = 'age', type = 'number'},
            },
            if_not_exists = true,
            engine = 'memtx',
            id = 542,
        })
        -- primary index
        customers_space:create_index('id_index', {
            parts = { {field = 'id'} },
            if_not_exists = true,
        })
        customers_space:create_index('bucket_id', {
            parts = { {field = 'bucket_id'} },
            unique = false,
            if_not_exists = true,
        })
        customers_space:create_index('name_index', {
            parts = { {field = 'name'} },
            unique = false,
            if_not_exists = true,
        })
    end

    return true
end

local function stop()
end

local function validate_config(conf_new, conf_old) -- luacheck: no unused args
    return true
end

local function apply_config(conf, opts) -- luacheck: no unused args
    -- if opts.is_master then
    -- end

    return true
end

return {
    role_name = 'app.roles.storage',
    dependencies = {
        'app.roles.custom',
        'cartridge.roles.crud-storage',
    },
    init = init,
    stop = stop,
    validate_config = validate_config,
    apply_config = apply_config,
}
