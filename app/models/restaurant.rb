class Restaurant < ApplicationRecord
  IMAGE_HASH = {
    asian:"https://media.istockphoto.com/id/545286388/photo/chinese-food-blank-background.jpg?s=612x612&w=0&k=20&c=pqOIy07YKO5PlU5VxjscwTGRrrZ8PluKMUjSOz-II60=",
    arabic:"https://media.istockphoto.com/id/924240792/photo/middle-eastern-or-arabic-dishes-and-assorted-meze-concrete-rustic-background.jpg?s=612x612&w=0&k=20&c=rPoKkUhe9DRGaFoRBqGFk2UHLcuRdE-JS1HNEqCqTVs=",
    mediterranean:"https://media.istockphoto.com/id/950253086/photo/middle-eastern-arabic-or-mediterranean-dinner-table-with-grilled-lamb-kebab-chicken-skewers.jpg?s=612x612&w=0&k=20&c=3PDeiLpn5qtBbB7PKf_fe5Ija3U1D5Ady9Prn0JR_C0=",
    south_american:"https://media.istockphoto.com/id/1421774574/photo/mexican-festive-food-for-independence-day-independencia-chiles-en-nogada-tacos-al-pastor.jpg?s=612x612&w=0&k=20&c=xC0K5-imOW123YxiLW6qvNAeXrFDSRBovUthdcngRvc=",
    tapas:"https://media.istockphoto.com/id/1350197620/es/foto/comida-espa%C3%B1ola.jpg?s=612x612&w=0&k=20&c=xuhPNhV56luoGi61mDiFMk1Syp_LZ6WJIkcTuI5Et9U=",
    italian:"https://blog.italotreno.com/wp-content/uploads/2023/10/Cosa_mangiare_Roma_10_piatti_imperdibili.jpg"
  }

  def image
    return super if super.present?
    IMAGE_HASH[category.downcase.gsub(" ","_").to_sym]
  end
end
