
module MyFilters
  def myfilter(x)
    "hiyo"
  end
  
  def personfilter(person)

    ## https://stackoverflow.com/questions/11410611/get-jekyll-configuration-inside-plugin
    cc = @context.registers[:site].config

    imgsrc = person['image'] ? 
      "#{cc['baseurl']}/assets/img/#{person['image']}" :
      "#{cc['baseurl']}/assets/img/blank.png"

    # bootstrap grid "small" is 576px wide total/  576/4=144
    # if you go narrower than "small", it appears that bootstrap switches over to single-column.
    # within a cell, it is useful to specify *larger* than implied min col
    # width, which is effective during the narrowscreen one-column failover
    # condition, e.g. browser window is 400px wide.

    out = %{
      <div id = "#{person['name'].gsub(" ","-")}" class="col-sm-3 person" style="margin:0 auto">
        <div style="margin:0 auto; padding-top:6px; padding-left:0; padding-right:0; max-width:250px">
            <center>
    }

    out += (
      img_html = %{
            <img style="max-width:143px; max-height: 143px; padding-left:0; padding-right:0;" 
              src="#{imgsrc}" alt="photo of #{person['name']}">}.strip
      if person['website']
        img_html = %{<a href= "#{person['website']}" target="_blank">#{img_html}</a>}
      end
      img_html
    )

    out += %{<p style="padding-top: 4px">}
      if person['website']
        out += %{<a href="#{person['website']}" target="_blank">#{person['name']}</a>}
      else
        out += person['name']
      end
      out += "<br>"
      if person['website']
        out += %{ <a href="#{person['website']}" target="_blank"><i class="fa fa-globe"></i></a>}
      end
      if person['twitter'] 
        out += %{ <a href="http://twitter.com/#{person['twitter']}" target="_blank"><i class="fab fa-twitter"></i></a>}
      end
      if person['email'] 
        out += %{ <a href="mailto:#{person['email']}" target="_blank"><i class="fa fa-envelope"></i></a>}
      end

      if person['dept']
        out += %{<br>}
        # out += %{<i>Dept.:</i> #{person['dept']}}
        out += %{<i>#{person['dept']}</i>}
      end


      if person['description']
        out += %{<br>}
        # out += %{<i>Interests</i>:<br> #{person['description']}}
        out += %{#{person['description']}}
        end
    out += %{</p>}

    out += %{
            </center>
        </div>
    </div>
    }
    out
  end
end

Liquid::Template.register_filter(MyFilters)

