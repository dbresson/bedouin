require 'bedouin/cli/params'
module Bedouin
  class CLI
    def execute(*params)
      p = Params.new(params)
      e = Bedouin.environment_for(p.env_path)

      p.template_paths.lazy.map do |path|
        t = Bedouin.template_for(path)
        j = Bedouin::Job.new(e, t)
        Bedouin::Runner.new.run(job: j, opts: p.opts)
      end.reduce(0) do |m,j|
        puts j.to_s
        j.status == 0 ? m : 1
      end
    end
  end
end
