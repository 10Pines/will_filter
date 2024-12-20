#--
# Copyright (c) 2017 Michael Berkovich, theiceberk@gmail.com
#
#  __    __  ____  _      _          _____  ____  _     ______    ___  ____
# |  |__|  ||    || |    | |        |     ||    || |   |      |  /  _]|    \
# |  |  |  | |  | | |    | |        |   __| |  | | |   |      | /  [_ |  D  )
# |  |  |  | |  | | |___ | |___     |  |_   |  | | |___|_|  |_||    _]|    /
# |  `  '  | |  | |     ||     |    |   _]  |  | |     | |  |  |   [_ |    \
#  \      /  |  | |     ||     |    |  |    |  | |     | |  |  |     ||  .  \
#   \_/\_/  |____||_____||_____|    |__|   |____||_____| |__|  |_____||__|\_|
#
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

module WillFilter
  module Containers
    class List < WillFilter::FilterContainer
      def self.operators
        [:is, :is_not, :contains, :does_not_contain]
      end

      def options
        opts = []
        filter.value_options_for(condition.key).each do |item|
          if item.is_a?(Array)
            opt_name = item.first.to_s
            opt_value = item.last.to_s
          else
            opt_name = item.to_s
            opt_value = item.to_s
          end
          next if opt_name.strip == ""
          opts << [ERB::Util.html_escape(opt_name), ERB::Util.html_escape(opt_value)]
        end
        opts
      end

      def sql_condition
        sanitized_value = value.to_s.downcase
        return [" #{condition.full_key} = ? ", value.to_s] if operator == :is
        return [" #{condition.full_key} <> ? ", value.to_s] if operator == :is_not
        return [" lower(#{condition.full_key}) like ? ", "%#{sanitized_value}%"] if operator == :contains
        return [" lower(#{condition.full_key}) not like ? ", "%#{sanitized_value}%"] if operator == :does_not_cotain
      end

    end
  end
end