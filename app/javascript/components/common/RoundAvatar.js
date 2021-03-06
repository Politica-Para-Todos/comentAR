/*
Copyright 2019 Politica para Todos

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import React, { PureComponent } from "react";
import PropTypes from 'prop-types';
import Avatar from 'antd/es/avatar';


function RoundAvatar({ imageUrl, title, subtitle, link }) {
    return (
        <a className="avatar-list-item" href={link}>
            <div className="avatar-list-item__content">
                <Avatar size={120} src={imageUrl} icon="user" />
                <h3 className="avatar-list-item__content-title">{title}</h3>
                <h4 className="avatar-list-item__content-subtitle">{subtitle}</h4>
            </div>
        </a>
    )
}

RoundAvatar.propTypes = {
    imageUrl: PropTypes.string,
    title: PropTypes.string.isRequired,
    subtitle: PropTypes.string,
}

RoundAvatar.defaultProps = {
    imageUrl: null,
    subtitle: null,
};
export default RoundAvatar;
