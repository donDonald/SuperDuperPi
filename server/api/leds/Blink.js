const util = require('util');
const exec_cb = require('child_process').exec;
const exec = util.promisify(exec_cb);


class Blink
{
    constructor()
    {
        this.name = "leds.Blink";
        this.target_directory = `${process.env.SUPER_DUPER_PI_SURVELIANCE_ROOT}/scripts/leds`;
    }

    log(message)
    {
        console.log(`[${this.name}] ${message}`);
    }

    async do(index, period, times)
    {
        this.log(`do(${index}, ${period}, ${times}) {`)
        let result;
        try
        {
            const cmd = `./blink.sh ${index} ${period} ${times}`;
            let {stdout, stderr} = await exec(cmd, {cwd: this.target_directory});
            result = [stdout, stderr];
        }
        catch (error)
        {
            throw error;
        }
        this.log(`} do(${index}, ${period}, ${times})`)
        return result[0];
    }
}


class Post
{
    constructor(app)
    {
        this.name = "leds.Blink.Post";
        this.blink = new Blink();
        app.post('/leds/api/blink', async (req, res) => {
            try
            {
                const index = req.body.index;
                const period = req.body.period;
                const times = req.body.times;
                const result = await this.blink.do(index, period, times);
                res.status(200).send(result);
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


module.exports = Post;
