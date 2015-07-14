RSpec.shared_context "Controller" do |controller_klass|
  let (:controller) do
    controller_klass.tap do |c|
      links = [{url: '/test', name: 'test'}]
      c.set :twitter, double()
      c.set :links, links
      c.set :show_exceptions, false
      c.set :raise_errors, true
      Capybara.app = c
    end
  end
end
