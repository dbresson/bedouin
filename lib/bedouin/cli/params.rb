module Bedouin
  class CLI
    class Params
      attr_reader :opts, :env_path, :template_paths
      def initialize(params)
        index_of_opt_terminator = params.find_index('--')
        unchecked_params = params.slice!((index_of_opt_terminator)..-1) if index_of_opt_terminator

        if args_count = params.reverse_each.find_index {|p| p.start_with? '-' }
          args, @opts  = params.pop(args_count), params
        else
          args, @opts = params, []
        end

        args.concat(unchecked_params.drop(1)) if unchecked_params
  
        @env_path, *@template_paths = *args
      end
    end
  end
end
