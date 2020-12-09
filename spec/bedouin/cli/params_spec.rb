require 'spec_helper'
require 'bedouin/cli/params'

describe Bedouin::CLI::Params do
  [
    {
      params: %w(environment foo),
      expect: {
        opts: [],
        env_path: 'environment',
        template_paths: ['foo']
      }
    },
    {
      params: %w(-- environment foo),
      expect: {
        opts: [],
        env_path: 'environment',
        template_paths: ['foo']
      }
    },
    {
      params: %w(environment foo bar),
      expect: {
        opts: [],
        env_path: 'environment',
        template_paths: ['foo', 'bar']
      }
    },
    {
      params: %w(-a -b -c environment foo bar),
      expect: {
        opts: ['-a', '-b', '-c'],
        env_path: 'environment',
        template_paths: ['foo', 'bar']
      }
    },
    {
      params: %w(-a -b -c -- environment foo bar),
      expect: {
        opts: ['-a', '-b', '-c'],
        env_path: 'environment',
        template_paths: ['foo', 'bar']
      }
    },
    {
      params: %w(-a -b -c -- -environment foo bar),
      expect: {
        opts: ['-a', '-b', '-c'],
        env_path: '-environment',
        template_paths: ['foo', 'bar']
      }
    }
  ].each do |c|
    context "for various parameter situations" do
      it "extracts cli parameters into opts, env_path, and template_paths" do
        p = Bedouin::CLI::Params.new(c[:params])
        expect(p).to have_attributes(c[:expect])
      end
    end
  end
end
