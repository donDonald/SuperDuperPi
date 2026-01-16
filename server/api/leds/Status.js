const util = require('util');
const exec_cb = require('child_process').exec;
const exec = util.promisify(exec_cb);


class Status {
    constructor() {
        this.name = "leds.Status";
        this.target_directory = `${process.env.SUPER_DUPER_PI_SURVELIANCE_ROOT}/scripts/leds`;
    }

    log(message) {
        console.log(`[${this.name}] ${message}`);
    }

    async do(index) {
        this.log(`do(${index}) {`)
        let result;
        try {
            const cmd = `./status.sh ${index}`;
            let {stdout, stderr} = await exec(cmd, {cwd: this.target_directory});
            result = [stdout, stderr];
        } catch (error) {
            throw error;
        }
        this.log(`} do(${index})`)
        return result[0];
    }
}


class Get {
    constructor(app) {
        this.name = "leds.Status.Get";
        this.status = new Status();
        app.get('/leds/api/status', async (req, res) => {
            try {
                const index = req.body.index;
                const status = await this.status.do(index);
                const lines = status.split('\n');
                const result = {};
                lines.forEach((line)=>{
                    if (line.length>0) {
                        const pairs = line.split(',');
                        const index_pair = pairs[1];
                        const index_value = index_pair.split(':');
                        const state_pair = pairs[2];
                        const key_value = state_pair.split(':');
                        const led = {};
                        led[key_value[0]] = key_value[1];
                        result[index_value[1]] = led;
                    }
                });
                res.status(200).json(result);
            } catch (error) {
                res.status(500).json({error:`${error}`, stdout:`${error.stdout}`});
            }
        });
    }

    log(message) {
        console.log(`[${this.name}] ${message}`);
    }
}


module.exports = Get;
