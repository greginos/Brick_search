class PartsController < ApplicationController
  skip_before_action :authenticate_user
end
