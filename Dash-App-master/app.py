# -*- coding: utf-8 -*-

# Run this app with `python app.py` and
# visit http://127.0.0.1:8050/ in your web browser.
#ver1-テキストで都道府県名を入力
#ver2-テキスト入力からプルダウンで選択する方式に変更
#ver3-男女別の人口の積み上げグラフ

import dash
import dash_core_components as dcc
import dash_html_components as html
import dash_table
import plotly.express as px
import pandas as pd
import numpy as np
import plotly.graph_objects as go
# from matplotlib import pyplot as plt
# from datetime import date
from dash.dependencies import Input, Output


#csvファイルの読み込み
data = pd.read_csv("c01.csv", 
                   header = 1,
                   names=["CODE","PRENAME","GENGO","JAPANYEAR","YEAR","CAUTION","NUMBER","MAILNUMBER","FEMAILNUMBER"],
                   encoding="SHIFT-JIS")
data = data.dropna(subset=["PRENAME"],axis=0)
data["JAPANYEAR"] = data["JAPANYEAR"].astype(np.int64)
data["YEAR"] = data["YEAR"].astype(np.int64)
data = data[data["NUMBER"] != "-"]
data["NUMBER"] = data["NUMBER"].astype(np.int64)

x = {}
l = []
for i in range(48):
    t = {"label":data["PRENAME"][i],"value":data["PRENAME"][i]}
    l.append(t)

external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']
app = dash.Dash(__name__, external_stylesheets=external_stylesheets)
#heroku用に追加
server = app.server
app.layout = html.Div(children=[
    html.H1(children='日本の人口推移'),
    html.Div(children='''
        出典：国勢調査：男女別人口ー全国, 都道府県（大正9年～平成27年）
    '''),
    # html.Div(["都道府県：", dcc.Input(id="my-input",value="全国",type="text")]),
    dcc.Dropdown(
        id='demo-dropdown',
        options =[{'label': '北海道', 'value': '北海道'},
                {'label': '青森県', 'value': '青森県'},
                {'label': '岩手県', 'value': '岩手県'},
                {'label': '宮城県', 'value': '宮城県'},
                {'label': '秋田県', 'value': '秋田県'},
                {'label': '山形県', 'value': '山形県'},
                {'label': '福島県', 'value': '福島県'},
                {'label': '茨城県', 'value': '茨城県'},
                {'label': '栃木県', 'value': '栃木県'},
                {'label': '群馬県', 'value': '群馬県'},
                {'label': '埼玉県', 'value': '埼玉県'},
                {'label': '千葉県', 'value': '千葉県'},
                {'label': '東京都', 'value': '東京都'},
                {'label': '神奈川県', 'value': '神奈川県'},
                {'label': '新潟県', 'value': '新潟県'},
                {'label': '富山県', 'value': '富山県'},
                {'label': '石川県', 'value': '石川県'},
                {'label': '福井県', 'value': '福井県'},
                {'label': '山梨県', 'value': '山梨県'},
                {'label': '長野県', 'value': '長野県'},
                {'label': '岐阜県', 'value': '岐阜県'},
                {'label': '静岡県', 'value': '静岡県'},
                {'label': '愛知県', 'value': '愛知県'},
                {'label': '三重県', 'value': '三重県'},
                {'label': '滋賀県', 'value': '滋賀県'},
                {'label': '京都府', 'value': '京都府'},
                {'label': '大阪府', 'value': '大阪府'},
                {'label': '兵庫県', 'value': '兵庫県'},
                {'label': '奈良県', 'value': '奈良県'},
                {'label': '和歌山県', 'value': '和歌山県'},
                {'label': '鳥取県', 'value': '鳥取県'},
                {'label': '島根県', 'value': '島根県'},
                {'label': '岡山県', 'value': '岡山県'},
                {'label': '広島県', 'value': '広島県'},
                {'label': '山口県', 'value': '山口県'},
                {'label': '徳島県', 'value': '徳島県'},
                {'label': '香川県', 'value': '香川県'},
                {'label': '愛媛県', 'value': '愛媛県'},
                {'label': '高知県', 'value': '高知県'},
                {'label': '福岡県', 'value': '福岡県'},
                {'label': '佐賀県', 'value': '佐賀県'},
                {'label': '長崎県', 'value': '長崎県'},
                {'label': '熊本県', 'value': '熊本県'},
                {'label': '大分県', 'value': '大分県'},
                {'label': '宮崎県', 'value': '宮崎県'},
                {'label': '鹿児島県', 'value': '鹿児島県'},
                {'label': '沖縄県', 'value': '沖縄県'},
                {'label': '全国', 'value': '全国'}],
        value="全国"
    ),
    html.Br(),
    dcc.Graph(
        id='update-graph'
    )
])
@app.callback(
    Output("update-graph","figure"),
    Input("demo-dropdown", "value")
)
def update_graph(input_value):
    data_zenkoku = data[data["PRENAME"]== input_value]
    data_syukei = pd.DataFrame({
        "YEAR":data_zenkoku["YEAR"],
        "MAILNUMBER":data_zenkoku["MAILNUMBER"],
        "FEMAILNUMBER":data_zenkoku["FEMAILNUMBER"]
    })
    data_syukei["YEAR"] = data_syukei["YEAR"].astype(str)
    data_syukei["MAILNUMBER"] = data_syukei["MAILNUMBER"].astype(np.int64)
    data_syukei["FEMAILNUMBER"] = data_syukei["FEMAILNUMBER"].astype(np.int64)
    # fig = px.bar(data_syukei,x="YEAR",y=["MAILNUMBER","FEMAILNUMBER"])
    fig = px.line(data_syukei,x="YEAR",y=["MAILNUMBER","FEMAILNUMBER"])
    # fig = go.Figure(
    #     data=[go.Bar(x="YEAR",y=data_zenkoku["NUMBER"],marker_color="red")],
    #     layout = go.Layout(
    #         title=go.layout.Title(text="人口推移")
    #     )
    # )
    # fig.update_traces(marker=dict(color=["LightSeaGreen","RoyalBlue"],opacity=0.4))
    # fig.update_traces(overwrite=True, marker={"opacity": 0.4})
    return fig
if __name__ == '__main__':
    app.run_server()
    # app.run_server(host = '0.0.0.0', port=8001, debug=True)
