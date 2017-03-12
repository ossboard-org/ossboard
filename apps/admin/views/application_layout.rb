module Admin
  module Views
    class ApplicationLayout
      include Admin::Layout

      def complexity_options_list
        COMPLEXITY_OPTIONS_HASH
      end

      def time_estimate_options_list
        TIME_ESTIMATE_OPTIONS_HASH
      end

    private

      COMPLEXITY_OPTIONS_HASH = {
        'Easy' => 'easy',
        'Medium' => 'medium',
        'Hard' => 'hard',
      }.freeze

      TIME_ESTIMATE_OPTIONS_HASH = {
        'Few days' => 'few days',
        'More than a week' => 'more than a week',
        'More than two weeks' => 'more than two weeks',
        'More than month' => 'more than month'
      }.freeze
    end
  end
end
