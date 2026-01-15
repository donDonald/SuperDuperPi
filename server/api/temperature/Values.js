const util = require('util');
const exec_cb = require('child_process').exec;
const exec = util.promisify(exec_cb);


class Values
{
    constructor()
    {
        this.name = "temperature.Values";
        this.target_directory = `${process.env.SUPER_DUPER_PI_SURVELIANCE_ROOT}/scripts/temperature`;
    }

    log(message)
    {
        console.log(`[${this.name}] ${message}`);
    }

    async do()
    {
        this.log(`do() {`)
        let result;
        try
        {
            const cmd = `./values.sh`;
            let {stdout, stderr} = await exec(cmd, {cwd: this.target_directory});
            result = [stdout, stderr];
        }
        catch (error)
        {
            throw error;
        }
        this.log(`} do()`)
        return result[0];
    }
}


class Get
{
    constructor(app)
    {
        this.name = "temperature.Values.Get";
        this.values = new Values();
        app.get('/temperature/api/values', async (req, res) => {
            try
            {
                const values = await this.values.do();
                const lines = values.split('\n');
                const result = {};
                lines.forEach((line)=>{
                    if (line.length>0) {
                        const pairs=line.split(',');
                        let id;
                        let sensor = {};
                        pairs.forEach((pair, index)=>{
                            const delimeter = index == 2 ? '=' : ':';
                            const key_value = pair.split(delimeter);
                            if (index == 0) {
                                id = key_value[1];
                            } else {
                                sensor[key_value[0]] = key_value[1];
                            }
                        });
                        result[id] = sensor;
                    }
                });
                res.status(200).json(result);
            }
            catch (error)
            {
                res.status(500).render('error', {
                    title: 'Error',
                    explanation0: `${error}`,
                    explanation1: `${error.stdout}`
                });
            }
        });
    }

    log(message)
    {
        console.log(`[${this.name}] ${message}`);
    }
}


module.exports = Get;
