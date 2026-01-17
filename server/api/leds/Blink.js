const util = require('util');
const exec_cb = require('child_process').exec;
const exec = util.promisify(exec_cb);


class Blink {
    constructor() {
        this.name = "leds.Blink";
        this.target_directory = `${process.env.SUPER_DUPER_PI_SURVELIANCE_ROOT}/scripts/leds`;
    }

    log(message) {
        console.log(`[${this.name}] ${message}`);
    }

    async do(index, period, times) {
        this.log(`do(${index}, ${period}, ${times}) {`)
        let result;
        try {
            const cmd = `./blink.sh ${index} ${period} ${times}`;
            let {stdout, stderr} = await exec(cmd, {cwd: this.target_directory});
            result = [stdout, stderr];
        } catch (error) {
            throw error;
        }
        this.log(`} do(${index}, ${period}, ${times})`)
        return result[0];
    }
}


class Post {
    constructor(app) {
        this.name = "leds.Blink.Post";
        this.blink = new Blink();
        app.post('/api/leds/blink', async (req, res) => {
            try {
                const index = req.body.index;
                const period = req.body.period;
                const times = req.body.times;
                const blink = await this.blink.do(index, period, times);
                const lines = blink.split('\n');
                const result = {};
                lines.forEach((line, index)=>{
                    if (line.length>0 && index == lines.length-2) {
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


module.exports = Post;
