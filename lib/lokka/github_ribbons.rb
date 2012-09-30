module Lokka
  module GithubRibbons
    def self.registered(app)
      app.get '/admin/plugins/github_ribbons' do
        haml :"plugin/lokka-github_ribbons/views/index", :layout => :"admin/layout"
      end

      app.put '/admin/plugins/github_ribbons' do
        Option.ribbon = params['ribbon']
        Option.githubid = params['githubid']
        flash[:notice] = 'Updated.'
        redirect '/admin/plugins/github_ribbons'
      end

      app.before do
        @ribbons = {
          "Lred" => "left_red_aa0000",
          "Lgre" => "left_green_007200",
          "Lblu" => "left_darkblue_121621",
          "Lora" => "left_orange_ff7600",
          "Lgra" => "left_gray_6d6d6d",
          "Lwhi" => "left_white_ffffff",
          "Rred" => "right_red_aa0000",
          "Rgre" => "right_green_007200",
          "Rblu" => "right_darkblue_121621",
          "Rora" => "right_orange_ff7600",
          "Rgra" => "right_gray_6d6d6d",
          "Rwhi" => "right_white_ffffff"
        }

        ribbon = Option.ribbon
        githubid = Option.githubid
        if !ribbon.blank? and !githubid.blank? and request.script_name != "admin"
          github_ribbon = "<a href=\"http://github.com/" + githubid + "\">"
          github_ribbon += "<img style=\"position: absolute; top: 0; "
          github_ribbon += (ribbon[0,1]=="R")? "right": "left"
          github_ribbon += ": 0; border: 0;\" src=\"https://s3.amazonaws.com/github/ribbons/forkme_" + @ribbons[ribbon] + ".png\" alt=\"Fork me on GitHub\"></a>"

          content_for :footer do
            github_ribbon
          end
        end
      end
    end
  end
end
