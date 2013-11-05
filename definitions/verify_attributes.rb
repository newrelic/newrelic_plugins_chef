# check required attributes
define :verify_attributes do
  missing_attributes = params[:attributes].select { |attribute| eval(attribute).nil? }
  unless missing_attributes.empty?
    Chef::Application.fatal!("You must provide the following attributes: #{missing_attributes.join(', ')}." +
        " For more information, see <INSERT_URL_HERE>")
  end
end