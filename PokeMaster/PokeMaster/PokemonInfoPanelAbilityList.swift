//
//  PokemonInfoPanelAbilityList.swift
//  PokeMaster
//
//  Created by Harlans on 2020/7/15.
//  Copyright © 2020 Harlans. All rights reserved.
//

import SwiftUI

extension PokemonInfoPanel
{
    struct AbilityList: View {
        let model: PokemonViewModel
        let abilityModels: [AbilityViewModel]?
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("技能")
                    .font(.headline)
                    .fontWeight(.bold)
                if abilityModels != nil {
                    ForEach(abilityModels!) { ability in
                        Text(ability.name)
                            .font(.subheadline)
                            .foregroundColor(self.model.color)
                        Text(ability.descriptionText)
                            .font(.footnote)
                        .foregroundColor(Color(hex: 0xAAAAAA))
                        .fixedSize(horizontal: false, vertical: true)
                        // 可以在竖直方向上显示全部文本，同时在水平方向上保持按照上层 View 的限制来换行
                    }
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
