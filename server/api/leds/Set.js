const util = require('util');
const exec_cb = require('child_process').exec;
const exec = util.promisify(exec_cb);


class Set
{
    constructor()
    {
        this.name = "leds.Set";
        this.target_directory = `${process.env.SUPER_DUPER_PI_SURVELIANCE_ROOT}/scripts/leds`;
    }

    log(message)
    {
        console.log(`[${this.name}] ${message}`);
    }

    async do(index, state)
    {
        this.log(`do(${index}, ${state}) {`)
        let result;
        try
        {
            const cmd = `./set.sh ${index} ${state}`;
            let {stdout, stderr} = await exec(cmd, {cwd: this.target_directory});
            result = [stdout, stderr];
        }
        catch (error)
        {
            throw error;
        }
        this.log(`} do(${index}, ${state})`)
        return result[0];
    }
}


class Post
{
    constructor(app)
    {
        this.name = "leds.Set.Post";
        this.set = new Set();
        app.post('/leds/api/set', async (req, res) => {
            try
            {
                const index = req.body.index;
                const state = req.body.state;
                const result = await this.set.do(index, state);
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
