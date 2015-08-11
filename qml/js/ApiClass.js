

var dataclass={
    "yiliaozhongxin": [
        {
            "name": "疾病信息",
            "id": "jibingxinxi",
            "apid":"disease"

        },
        {
            "name": "病状查找",
            "id": "jibingchazhao",
            "apid":"symptom"
        },
        {
            "name": "检查项目",
            "id": "jianchaxiangmu",
            "apid":"check"
        },
        {
            "name": "手术项目",
            "id": "shoushuxiangmu",
            "apid":"surgery"
        }
    ],
    "qiyedaquan": [
        {
            "name": "医院大全",
            "id": "yiyuandaquan",
            "apid":"hospital"
        },
        {
            "name": "药店大全",
            "id": "yaodiandaquan",
            "apid":"store"
        },
        {
            "name": "药企大全",
            "id": "yaoqidaquan",
            "apid":"surgery"
        }
    ],

    "wenhuazhishi": [
        {
            "name": "健康知识",
            "id": "jiankangzhishi",
            "apid":"lore"
        },
        {
            "name": "健康一问",
            "id": "jiankangyiwen",
            "apid":"ask"
        },
        {
            "name": "健康图书",
            "id": "jiankangtushu",
            "apid":"book"
        }
    ],
    "yaopinshipin": [
        {
            "name": "药品直达",
            "id": "yaopinzhida",
            "apid":"drug"
        },
        {
            "name": "食疗大全",
            "id": "shiliaodaquan",
            "apid":"food"
        },
        {
            "name": "健康食谱",
            "id": "jiankangshipu",
            "apid":"cook"
        }
    ],
    "xinwenzixun": [
        {
            "name": "健康资讯",
            "id": "jiankangzixun",
            "apid":"news"
        },
        {
            "name": "热点热词",
            "id": "redianreci",
            "apid":"top"
        }
    ],
    "meinv":[
        {
            "name":"美女图片",
            "id":"meinv",
            "apid":"sex"
        }
    ]
}

function currentClass(classname){
    for(var i in dataclass[classname]){
     classmodel.append(dataclass[classname][i]);
    }
}
